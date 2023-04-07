from prometheus_client import start_http_server, Summary, Gauge, REGISTRY, GC_COLLECTOR, PLATFORM_COLLECTOR, PROCESS_COLLECTOR
import random
import time
import psutil

available_memory = Gauge("available_memory", "Available Memory in MB")
total_memory = Gauge("total_memory", "Total Memory in MB")
used_memory = Gauge("used_memory", "Used Memory in MB")
free_memory = Gauge("free_memory", "Free Memory in MB")


def unregister():
    REGISTRY.unregister(GC_COLLECTOR)
    REGISTRY.unregister(PLATFORM_COLLECTOR)
    REGISTRY.unregister(PROCESS_COLLECTOR)


def process_request(t):
    available_memory.set(psutil.virtual_memory()[1]/1000000)
    total_memory.set(psutil.virtual_memory()[0]/1000000)
    used_memory.set(psutil.virtual_memory()[3]/1000000)
    free_memory.set(psutil.virtual_memory()[4]/1000000)
    time.sleep(t)


if __name__ == '__main__':
    start_http_server(8888)
    unregister()
    while True:
        process_request(2)
