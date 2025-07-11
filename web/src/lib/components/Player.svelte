<script lang="ts">
import { type PlayerData } from "$lib/typings";

let { ply }: { ply: PlayerData } = $props();
</script>

<div class="flex items-center gap-2 fadeIn">
    <div class="w-16 h-14 border border-[#0bd9b0] rounded-sm flex items-center justify-center prodigy-user-box">
        <i class="fa-solid fa-user prodigy-text text-2xl"></i>
    </div>
    <div class="prodigy-mainBg h-14 w-full flex items-center justify-between px-4 text-[15px]">
        <p class="prodigy-text font-medium">{ply.username} {ply.id && `[${ply.id}]`}</p>
        <p class="bg-[#0f6957a0] text-[13px] px-3 py-0.5 text-[#2bd8b5] uppercase">{ply.steam}</p>
    </div>
</div>