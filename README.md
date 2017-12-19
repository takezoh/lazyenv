# lazyenv

lazyenv provides the delayed calling function associated with the specified commands.

# Usage

lazyenv.load gives the function name of the initialization process as the first argument, and the command name to be associated with the initialization process as after the second argument.

```
source /path/to/lazyenv.bash
_**env_init() {
    export **ENV_ROOT=`brew --prefix **env`
    eval "$(**env init -)"
}
eval "$(lazyenv.load _**env_init `ls /path/to/**env/shims`)"
```

This will delay the execution of **env init until you execute the under **env/shims commands.

# License

lazyenv is licensed under the Apache License 2.0, see LICENSE.
