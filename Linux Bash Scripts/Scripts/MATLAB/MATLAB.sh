echo $((4000000000)) | sudo tee /sys/fs/cgroup/memory/memoryLimitGroup2/memory.limit_in_bytes

cgexec -g memory:memoryLimitGroup2 matlab -desktop &
