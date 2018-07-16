# YADM_STATUS values
# 0 - nothing to do
# 1 - yadm has unsaved changes
# 2 - yadm changes need to be pushed to the remote
export YADM_STATUS=0

_update_yadm_status () {
    local branch_name ahead
    if [[ $(yadm status -s) ]]; then
        message='%B%F{magenta}There are local configuration changes. Yadm sync required.%f%b'
        YADM_STATUS=1
    else
        branch_name=$(yadm symbolic-ref --short HEAD 2>/dev/null)
        ahead=$(yadm rev-list "${branch_name}"@{upstream}..HEAD 2>/dev/null | wc -l)
        if (( ahead )); then
            YADM_STATUS=2
        else
            YADM_STATUS=0
        fi
    fi
}

_prompt_yadm_status () {
    if [[ $YADM_STATUS -eq 1 ]]; then
        print -P '%B%F{magenta}There are local configuration changes. Yadm sync required.%f%b'
    elif [[ $YADM_STATUS -eq 2 ]]; then
        print -P '%B%F{magenta}Run yadm push.%f%b'
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook periodic _update_yadm_status
add-zsh-hook precmd _prompt_yadm_status

# Aliases
alias y=yadm
alias ya='yadm add'
alias yaa='yadm add -u'
alias yap='yadm apply'
alias yapa='yadm add --patch'
alias yau='yadm add --update'
alias yb='yadm branch'
alias yba='yadm branch -a'
alias ybd='yadm branch -d'
alias ybda='yadm branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 yadm branch -d'
alias ybl='yadm blame -b -w'
alias ybnm='yadm branch --no-merged'
alias ybr='yadm branch --remote'
alias ybs='yadm bisect'
alias ybsb='yadm bisect bad'
alias ybsg='yadm bisect good'
alias ybsr='yadm bisect reset'
alias ybss='yadm bisect start'
alias yc='yadm commit -v'
alias 'yc!'='yadm commit -v --amend'
alias yca='yadm commit -v -a'
alias 'yca!'='yadm commit -v -a --amend'
alias ycam='yadm commit -a -m'
alias 'ycan!'='yadm commit -v -a --no-edit --amend'
alias 'ycans!'='yadm commit -v -a -s --no-edit --amend'
alias ycb='yadm checkout -b'
alias ycd='yadm checkout develop'
alias ycf='yadm config --list'
alias ycl='yadm clone --recursive'
alias yclean='yadm clean -fd'
alias ycm='yadm checkout master'
alias 'ycn!'='yadm commit -v --no-edit --amend'
alias yco='yadm checkout'
alias ycount='yadm shortlog -sn'
alias ycp='yadm cherry-pick'
alias ycpa='yadm cherry-pick --abort'
alias ycpc='yadm cherry-pick --continue'
alias ycs='yadm commit -S'
alias ycsm='yadm commit -s -m'
alias yd='yadm diff'
alias ydca='yadm diff --cached'
alias ydct='yadm describe --tags `yadm rev-list --tags --max-count=1`'
alias ydcw='yadm diff --cached --word-diff'
alias ydiff='yadm diff --no-index'
alias ydt='yadm diff-tree --no-commit-id --name-only -r'
alias ydw='yadm diff --word-diff'
alias yf='yadm fetch'
alias yfa='yadm fetch --all --prune'
alias yfo='yadm fetch origin'
alias yy='yadm gui citool'
alias yya='yadm gui citool --amend'
alias yypull='yadm pull'
alias yypush='yadm push'
alias yh='yadm browse'
alias yhh='yadm help'
alias yignore='yadm update-index --assume-unchanged'
alias yignored='yadm ls-files -v | grep "^[[:lower:]]"'
alias yk='\yadmk --all --branches'
alias yke='\yadmk --all $(yadm log -g --pretty=%h)'
alias yl='yadm pull'
alias ylg='yadm log --stat'
alias ylgg='yadm log --graph'
alias ylgga='yadm log --graph --decorate --all'
alias ylgm='yadm log --graph --max-count=10'
alias ylgp='yadm log --stat -p'
alias ylo='yadm log --oneline --decorate'
alias ylog='yadm log --oneline --decorate --graph'
alias yloga='yadm log --oneline --decorate --graph --all'
alias ylol='yadm log --graph --pretty='\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias ylola='yadm log --graph --pretty='\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit --all'
alias ylp=_yadm_log_prettily
alias ylum='yadm pull upstream master'
alias ym='yadm merge'
alias yma='yadm merge --abort'
alias ymom='yadm merge origin/master'
alias ymt='yadm mergetool --no-prompt'
alias ymtvim='yadm mergetool --no-prompt --tool=vimdiff'
alias ymum='yadm merge upstream/master'
alias yp='yadm push'
alias ypd='yadm push --dry-run'
alias ypoat='yadm push origin --all && yadm push origin --tags'
alias ypristine='yadm reset --hard && yadm clean -dfx'
alias ypsup='yadm push --set-upstream origin $(yadm_current_branch)'
alias ypu='yadm push upstream'
alias ypv='yadm push -v'
alias yr='yadm remote'
alias yra='yadm remote add'
alias yrb='yadm rebase'
alias yrba='yadm rebase --abort'
alias yrbc='yadm rebase --continue'
alias yrbi='yadm rebase -i'
alias yrbm='yadm rebase master'
alias yrbs='yadm rebase --skip'
alias yrep='grep  --color=auto --exclude-dir={.bzr,CVS,.yadm,.hg,.svn}'
alias yrh='yadm reset HEAD'
alias yrhh='yadm reset HEAD --hard'
alias yrmv='yadm remote rename'
alias yrrm='yadm remote remove'
alias yrset='yadm remote set-url'
alias yrt='cd $(yadm rev-parse --show-toplevel || echo ".")'
alias yru='yadm reset --'
alias yrup='yadm remote update'
alias yrv='yadm remote -v'
alias ysb='yadm status -sb'
alias ysd='yadm svn dcommit'
alias ysi='yadm submodule init'
alias ysps='yadm show --pretty=short --show-signature'
alias ysr='yadm svn rebase'
alias yss='yadm status -s'
alias yst='yadm status'
alias ysta='yadm stash save'
alias ystaa='yadm stash apply'
alias ystc='yadm stash clear'
alias ystd='yadm stash drop'
alias ystl='yadm stash list'
alias ystp='yadm stash pop'
alias ysts='yadm stash show --text'
alias ysu='yadm submodule update'
alias yts='yadm tag -s'
alias ytv='yadm tag | sort -V'
alias yunignore='yadm update-index --no-assume-unchanged'
alias yunwip='yadm log -n 1 | grep -q -c "\-\-wip\-\-" && yadm reset HEAD~1'
alias yup='yadm pull --rebase'
alias yupv='yadm pull --rebase -v'
alias ywch='yadm whatchanged -p --abbrev-commit --pretty=medium'
alias ywip='yadm add -A; yadm rm $(yadm ls-files --deleted) 2> /dev/null; yadm commit --no-verify -m "--wip-- [skip ci]"'
