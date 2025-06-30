if [ -f "/tmp/nvim_test_file" ]; then
    rm /tmp/nvim_test_file
fi
touch /tmp/nvim_test_file

nvim -c 'call feedkeys("iHello\<C-c>")' -c "wq" /tmp/nvim_test_file

if [ "$(cat /tmp/nvim_test_file)" = 'Hello' ]; then
  echo 'Content matches'
else
  echo 'Content does not match'
  echo "$(cat /tmp/nvim_test_file)"
fi


