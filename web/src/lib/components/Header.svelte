<script lang="ts">
let { players, query } = $props();
let progress = (players.online.length / players.maxPlayers) * 100;
</script>

<div class="flex justify-between items-center pr-4">
    <div class="flex items-center gap-5 text-2xl text-white">
        <p class="font-medium">Player List</p>
        <div class="flex items-center gap-3 text-lg">
            <i class="fa-solid fa-users"></i>
            <p>{players.online.length} / {players.maxPlayers}</p>
        </div>
    </div>
    <div class="flex gap-3 items-center">
        <input type="text" oninput={(e) => query((e.target as HTMLInputElement).value)}
        class="bg-black/65 rounded px-3 py-1.5 text-white border border-zinc-500/50 focus:outline-none">
        <i class="fa-solid fa-magnifying-glass text-white text-xl"></i>
    </div>
</div>
<div class="my-3 mr-4 w-fill h-2 bg-black/65 rounded-full overflow-hidden border border-zinc-500/50"><div class="bg-lime-400 h-full" style="width: {progress}%"></div></div>