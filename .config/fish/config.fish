#=============#
#   aliases   #
#=============#

# xbps
alias query   "apt search"
alias add     "sudo apt install"
alias update  "sudo apt update"
alias remove  "sudo apt remove"

alias love "/Applications/love.app/Contents/MacOS/love"

# git
abbr gti  "git"
abbr ga   "git add"
abbr gaa  "git add --all ."
abbr comm "git commit"
abbr gsw  "git switch"
abbr pull "git pull"
abbr push "git push -u origin HEAD"

abbr recommit "git commit --amend --no-edit --no-verify"

# docker
abbr dcb "docker-compose build"
abbr dcu "docker-compose up"
abbr dcr "docker-compose run --rm"
abbr dps "docker ps"
abbr up   "dcu"

# tmux
alias mux tmuxinator
abbr -g att  "tmux a -t"
abbr -g t "tmux new -As"

# misc
abbr :q "exit"
abbr chmox "chmod +x"

#===============#
#   functions   #
#===============#

function enable
  sudo ln -s "/etc/sv/$argv" /var/service/
end

complete -c enable -x -a "(ls /etc/sv)"

function save
  git add . && git commit -m (date -I) && git push
end

function proj
  cd ~/projects/"$argv" && tmux new -As "$argv"
end

complete -c proj -x -a "(ls ~/projects)"

function notes
  cd ~/notes/"$argv" && tmux new -As "$argv"
end

complete -c notes -x -a "(ls ~/notes)"

function mp3
  for f in *.wav *.m4a
    if test -f "$f"
      set output (string replace -r '\.(wav|m4a)$' '.mp3' $f)
      ffmpeg -i "$f" -b:a 320k "$output" && rm "$f"
    end
  end
end

function download
    yt-dlp -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata $argv
end

#=========#
#   env   #
#=========#

set -x EDITOR nvim
set -x VISUAL nvim

# disable message
set fish_greeting 

# luarocks
# eval (luarocks path)
eval (luarocks --lua-version 5.1 path)

# opencode
fish_add_path /Users/brennop/.opencode/bin
