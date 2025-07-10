<script lang="ts">
let { totalPlayers } = $props();
</script>

<div class="flex items-center justify-between">
    <div class="flex flex-col gap-0 font-[Oswald]">
        <p class="uppercase text-2xl font-semibold prodigy-text">PLAYER LIST</p>
        <p class="text-sm text-gray-400">HERE YOU CAN SEE ALL PLAYERS</p>
    </div>
    <div class="text-sm text-white font-light flex items-center">
        <p class="bg-yellow-300/20 px-4 py-0.5">TOTAL PLAYERS</p>
        <p class="px-4 py-0.5 bg-yellow-300/40">{totalPlayers}</p>
    </div>
    <div class="text-gray-400 flex text-[13px] bg-gray-700 p-0.5">
        <p class="px-2 bg-gray-800">Exit</p>
        <p class="px-2">ESC</p>
    </div>
</div>