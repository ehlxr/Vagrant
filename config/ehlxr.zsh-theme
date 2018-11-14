# VCS
YS_VCS_PROMPT_PREFIX1="%{$fg[white]%}(%{$reset_color%}"
YS_VCS_PROMPT_PREFIX2="%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"
YS_VCS_PROMPT_CLOSE="%{$fg[white]%}) %{$reset_color%}"


# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="${YS_VCS_PROMPT_DIRTY}${YS_VCS_PROMPT_CLOSE}"
ZSH_THEME_GIT_PROMPT_CLEAN="${YS_VCS_PROMPT_CLEAN}${YS_VCS_PROMPT_CLOSE}"

# root user
local root_symbols
[[ $UID -eq 0 ]] && root_symbols+=" %{%F{yellow}%}*"

# background jobs
local bg_symbols='$(prompt_background_jobs)'
prompt_background_jobs() {
  local background_jobs_number=${$(jobs -l | wc -l)// /}

  if [[ background_jobs_number -gt 0 ]]; then
    echo " %{%F{cyan}%}&"
  fi
}

local exit_code="%(?,, C:%{$fg[red]%}%?%{$reset_color%})"

# PROMPT="
# %{$terminfo[bold]$fg[blue]%}⌘%{$reset_color%} \
# %{$terminfo[bold]$fg[yellow]%}%~ %{$reset_color%}\
# ${git_info}\
# %{$fg[white]%}[%*]\
# ${root_symbols}${bg_symbols}\
# $exit_code
# %{%F{green}%}➜ %{$reset_color%}"

PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%{$fg[cyan]%}%n \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}%~ %{$reset_color%}\
${git_info}\
%{$fg[white]%}[%*]\
${root_symbols}${bg_symbols}\
%(?,%{$fg[green]%}, %{$fg[red]%})
➜ %{$reset_color%}"