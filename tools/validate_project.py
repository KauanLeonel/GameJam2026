"""Validate GameMaker resource links without changing the project."""
from pathlib import Path
import json
import re
import struct

ROOT = Path(__file__).resolve().parents[1]


def load(path):
    return json.loads(re.sub(r",\s*([}\]])", r"\1", path.read_text(encoding="utf-8-sig")))


def main():
    project = load(ROOT / "GameJam2026.yyp")
    folders = {folder["folderPath"] for folder in project["Folders"]}
    resources = {entry["id"]["path"]: entry["id"]["name"] for entry in project["resources"]}
    errors = []
    names = list(resources.values())
    if len(names) != len(set(names)):
        errors.append("Duplicate resource names")
    if project["RoomOrderNodes"][0]["roomId"]["name"] != "rm_boot":
        errors.append("First room must be rm_boot")

    for relative, name in resources.items():
        path = ROOT / relative
        if not path.is_file():
            errors.append(f"Missing resource: {relative}")
            continue
        data = load(path)
        if data["name"] != name:
            errors.append(f"Resource name mismatch: {relative}")
        if data.get("parent", {}).get("path") not in folders:
            errors.append(f"Unknown asset folder: {relative}")
        ancestor = data.get("parentObjectId")
        if ancestor and resources.get(ancestor["path"]) != ancestor["name"]:
            errors.append(f"Unknown parent object: {relative}")
        kind = data["resourceType"]
        if kind == "GMScript" and not path.with_suffix(".gml").is_file():
            errors.append(f"Missing script source: {relative}")
        if kind == "GMObject":
            event_types = {0: "Create", 3: "Step", 7: "Other", 8: "Draw"}
            for event in data["eventList"]:
                event_name = f"{event_types[event['eventType']]}_{event['eventNum']}.gml"
                if not (path.parent / event_name).is_file():
                    errors.append(f"Missing object event: {name}/{event_name}")
        if kind == "GMRoom":
            instances = []
            for layer in data["layers"]:
                for instance in layer.get("instances", []):
                    instances.append(instance["name"])
                    obj = instance["objectId"]
                    if resources.get(obj["path"]) != obj["name"]:
                        errors.append(f"Missing room object: {relative}")
            order = [item["name"] for item in data["instanceCreationOrder"]]
            if sorted(order) != sorted(instances):
                errors.append(f"Room creation order mismatch: {relative}")
            if name != "rm_boot" and any(instance["objectId"]["name"] == "obj_game"
                                         for layer in data["layers"] for instance in layer.get("instances", [])):
                errors.append(f"Persistent controller duplicated in {name}")
        if kind == "GMSprite":
            for frame in data["frames"]:
                images = [path.parent / f"{frame['name']}.png"]
                images += [path.parent / "layers" / frame["name"] / f"{layer['name']}.png" for layer in data["layers"]]
                for image in images:
                    if not image.is_file():
                        errors.append(f"Missing sprite image: {image.relative_to(ROOT)}")
                        continue
                    raw = image.read_bytes()
                    if raw[:8] != b"\x89PNG\r\n\x1a\n" or struct.unpack(">II", raw[16:24]) != (data["width"], data["height"]):
                        errors.append(f"Invalid sprite image dimensions: {image.relative_to(ROOT)}")
        if kind == "GMFont":
            if not path.with_suffix(".png").is_file():
                errors.append(f"Missing font atlas: {relative}")
            for char in "áàâãéêíóôõúçÁÀÂÃÉÊÍÓÔÕÚÇ":
                if str(ord(char)) not in data["glyphs"]:
                    errors.append(f"Missing Portuguese font glyph {char}: {relative}")

    for node in project["RoomOrderNodes"]:
        if resources.get(node["roomId"]["path"]) != node["roomId"]["name"]:
            errors.append("Room order references an unregistered resource")
    ordering = load(ROOT / "GameJam2026.resource_order")
    for folder in ordering["FolderOrderSettings"]:
        if folder.get("path") not in folders:
            errors.append("Invalid folder ordering reference")
    for resource in ordering["ResourceOrderSettings"]:
        if resources.get(resource.get("path")) != resource.get("name"):
            errors.append("Invalid resource ordering reference")
    for directory in ("objects", "scripts", "sprites", "rooms", "fonts"):
        for path in (ROOT / directory).glob("*/*.yy"):
            if path.relative_to(ROOT).as_posix() not in resources:
                errors.append(f"Unregistered resource: {path.relative_to(ROOT)}")
    if errors:
        raise SystemExit("\n".join(errors))
    print(f"OK: {len(resources)} resources, {len(folders)} folders, {len(project['RoomOrderNodes'])} rooms; all links and sprite images valid.")


if __name__ == "__main__":
    main()
