# Copyright (c) 2018 Ultimaker B.V.
# Cura is released under the terms of the LGPLv3 or higher.

from . import SupportEraser

from UM.i18n import i18nCatalog

i18n_catalog = i18nCatalog("cura")


def getMetaData():
    return {
        "tool": {
            "name": i18n_catalog.i18nc("@label", "Place Modifier Cube"),
            "description": i18n_catalog.i18nc(
                "@info:tooltip", "Create a volume in which supports can be modified."
            ),
            "icon": "SupportBlocker",
            "weight": 4,
        }
    }


def register(app):
    return {"tool": SupportEraser.SupportEraser()}
