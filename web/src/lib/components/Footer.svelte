<script lang="ts">
import type { JobData } from "$lib/typings";

let { jobs }: { jobs: JobData[] } = $props()
</script>

<div class="flex items-center gap-1 flex-wrap mt-2 mr-1 pr-2 max-h-20 overflow-auto">
    {#each jobs as job}
        <div class="flex text-white items-center gap-3 bg-black/50 w-fit px-5 py-0.5 rounded-full border border-zinc-600/50">
            <p>{job.label}</p>
            <p class="font-bold text-lg">{job.count}</p>
        </div>
    {/each}
</div>