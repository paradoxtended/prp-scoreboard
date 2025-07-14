<script lang="ts">
import { type PlayerData } from "$lib/typings";

let { player }: { player: PlayerData } = $props();
</script>

<div class="w-full bg-black/65 rounded px-5 py-3 flex items-center justify-between text-white text-xl border border-zinc-600/50">
    <div class="flex items-center gap-3">
        <i class="fa-regular fa-user"></i>
        <p>{player.username}</p>
    </div>
    {#if player.id}
        <p class="bg-black/65 px-2 py-0.5 rounded border border-zinc-600/50">{player.id}</p>
    {/if}
</div>