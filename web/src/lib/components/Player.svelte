<script lang="ts">
import { type PlayerData } from "$lib/typings";

let { ply }: { ply: PlayerData } = $props();
</script>

<div class="prodigy-bg flex items-center justify-between cursor-pointer
hover:-translate-x-5 duration-200 group">
    <div class="flex items-center gap-5 group-hover:prodigy-text font-medium text-[17px] duration-200">
        <i class="fa-regular fa-user"></i>
        <p>{ply.username}</p>
    </div>
    <p class="bg-lime-950 px-3 py-0.5">{ply.id}</p>
</div>