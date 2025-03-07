MODPATH="{$0%/*}"
sleep 10
echo 3598M > /sys/block/zram0/disksize
mkswap /data/zram0
swapon  /data/zram0
# VM settings to improve overall user experience and performance
echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate
echo 60 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold
echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
echo 5 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
echo 100000 > /proc/sys/kernel/sched_rt_period_us
echo 95000 > /proc/sys/kernel/sched_rt_runtime_us 
echo 100 > /proc/sys/vm/swappiness
echo 10 > /proc/sys/vm/dirty_ratio
echo 4 > /proc/sys/vm/dirty_background_ratio
echo 4096 > /proc/sys/vm/min_free_kbytes
echo 500 > /proc/sys/vm/vfs_cache_pressure
echo 0 > /proc/sys/vm/oom_kill_allocating_task
echo 0 > /proc/sys/vm/laptop_mode
echo 0 > /proc/sys/vm/panic_on_oom
echo 0 > /proc/sys/kernel/tainted
echo 3 > /proc/sys/vm/drop_caches
echo 3 > /proc/sys/vm/page-cluster
echo 10 > /proc/sys/fs/lease-break-time
echo 1 > /proc/sys/vm/overcommit_memory
echo 100 > /proc/sys/vm/overcommit_ratio
echo 200 > /proc/sys/vm/dirty_expire_centisecs
echo 500 > /proc/sys/vm/dirty_writeback_centisecs
echo 10000000 > /proc/sys/kernel/sched_latency_ns
echo 0 > /proc/sys/kernel/sched_wakeup_granularity_ns
echo 2000000 > /proc/sys/kernel/sched_min_granularity_ns
echo 725000 > /proc/sys/kernel/sched_shares_ratelimit
echo 3000 > /proc/sys/vm/watermark_scale_factor
echo 1 > /proc/sys/vm/compact_memory
echo 7035 > /sys/class/touch/switch/set_touchscreen
echo 8002 > /sys/class/touch/switch/set_touchscreen
echo 11000 > /sys/class/touch/switch/set_touchscreen
echo 13060 > /sys/class/touch/switch/set_touchscreen
echo 14005 > /sys/class/touch/switch/set_touchscreen
echo 160 267 300 > /sys/class/misc/gpu_clock_control/gpu_control
echo 70% 40% 80% 60% > /sys/class/misc/gpu_clock_control/gpu_control
echo 950000 1000000 1100000 > /sys/class/misc/gpu_voltage_control/gpu_control
renice -20 `pidof com.android.phone`
renice -18 `pidof com.android.contacts`
renice -18 `pidof com.android.mms`
renice -18 `pidof com.android.systemui`
renice -4 `pidof android.process.acore`
killall -9 `pidof android.process.media`
