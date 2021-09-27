import hub

# Turn off Bluetooth classic discoverability but only for Gecko hubs.
# Has to happen here because advertising starts before main.py is loaded
if hub.info().get("product_variant", 0) == 3 or not hasattr(hub, "display"):
    hub.config["bt_discoverable"] = 0
