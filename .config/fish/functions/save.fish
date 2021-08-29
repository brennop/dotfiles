function save
  git add . && git commit -m (date -I) && git push
end

