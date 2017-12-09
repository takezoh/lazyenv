#!bash
#
# Copyright 2017 Takehito Gondo
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


lazyenv.load() {
	local func=$1
	shift

	echo "_lazyenv_${func}_commands=($@)"

	for cmd in $@; do
		echo "$cmd() { eval \"\$(_lazyenv.init $cmd $func \$@)\"; }"
	done
}

lazyenv.shell.loadstart() {
	_lazyenv_shell_loading=true
}

lazyenv.shell.loadfinish() {
	if [ ! -z "$_lazyenv_shell_loading" ]; then
		unset _lazyenv_shell_loading
	fi
}

_lazyenv.init() {
	local cmd=$1
	local func=$2
	shift
	shift

	if [ ! -z "$_lazyenv_shell_loading" ]; then
		cat <<EOF
command $cmd "\$@"
EOF
		return
	fi

	cat <<EOF
for _cmd in \${_lazyenv_${func}_commands[@]}; do
	unset -f \$_cmd
done
unset _lazyenv_${func}_commands

eval '$func $cmd'
unset -f $func

eval '$cmd "\$@"'
EOF
}
