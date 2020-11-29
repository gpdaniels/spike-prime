from hub import battery

# Returns:
# - temperature:             The current temperature of the battery in degree Celsius.
# - charge_voltage:          The voltage being used for charging.
# - charge_current:          The current being used for charging.
# - charge_voltage_filtered: The battery voltage after filtering in millivolts.
# - error_state:             Enum of battery errors.
# - charger_state:           Enum of the charger state.
# - battery_capacity_left:   Percentage of battery charge remaining, 0 to 100.
battery.info()
