# Module template

This template represents a module and serves as a way to document its features.

## Structure

- `<module>`: The root of the module dir, named after the module it configures.
- `<module>/__xdg_cache_home__`: A special directory that is automatically symlinked to `$XDG_CACHE_HOME/<module>`.
- `<module>/__xdg_config_home__`: A special directory that is automatically symlinked to `$XDG_CONFIG_HOME/<module>`.
- `<module>/__xdg_data_home__`: A special directory that is automatically symlinked to `$XDG_DATA_HOME/<module>`.
- `<module>/__xdg_state_home__`: A special directory that is automatically symlinked to `$XDG_STATE_HOME/<module>`.