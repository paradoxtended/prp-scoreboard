<script lang="ts">
import Header from "$lib/components/Header.svelte";
import Player from "$lib/components/Player.svelte";
import { useNuiEvent } from "$lib/hooks/useNuiEvent";
import { type PlayerData } from "$lib/typings";
import { debugData } from "$lib/utils/debugData";
    import { fetchNui } from "$lib/utils/fetchNui";
import { isEnvBrowser } from "$lib/utils/misc";

let visible: boolean = $state(false);
let players: { online?: PlayerData[], offline?: PlayerData[] } = $state({});

let currentTab = $state('online')

debugData<{ online: PlayerData[], offline?: PlayerData[] }>([
  {
    action: 'showList',
    data: {
      online: [
        { username: 'Koil', id: 487, steam:   'STEAM:15487564' },
        { username: 'Ravage', id: 354, steam: 'STEAM:48979845' },
        { username: 'buddha', id: 105, steam: 'STEAM:94615612' }
      ],
      offline: [
        { username: 'xQc', steam: 'STEAM:87514231' },
        { username: 'saabb', steam: 'STEAM:47512489' },
      ]
    }
  }
])

if (isEnvBrowser()) {
  const root = document.getElementById('app');

  // https://i.imgur.com/iPTAdYV.png - Night time img
  root!.style.backgroundImage = 'url("https://i.imgur.com/3pzRj9n.png")';
  root!.style.backgroundSize = 'cover';
  root!.style.backgroundRepeat = 'no-repeat';
  root!.style.backgroundPosition = 'center';
}

useNuiEvent('showList', (data: { online: PlayerData[], offline?: PlayerData[] }) => {
  visible = true;
  players = data;
})

function handleClose() {
  const wrapper = document.querySelector('.wrapper') as HTMLElement;
  wrapper!.style.animation = 'slideOut 250ms forwards';
  setTimeout(() => visible = false, 250);

  fetchNui('hideList');
}

function onKeyDown(event: KeyboardEvent) {
  const key = event.key.toLowerCase();

  switch (key) {
    case 'escape':
      return handleClose()
  } 
}
</script>

<svelte:window onkeydown={onKeyDown} />

{#if visible}
  <div class="w-[550px] prodigy-bg rounded-3xl top-1/2 left-[84%] absolute -translate-x-1/2 -translate-y-1/2 p-7 wrapper">
      <Header totalPlayers={players.online.length} />
      <div class="mt-2 flex items-center gap-3 text-[15px]">
        <p class={`text-[#0bd9b0] prodigy-mainBg py-1.5 text-center w-full cursor-pointer border rounded-sm
        hover:border-[#0bd9b0] hover:prodigy-hoverBg duration-100
        ${currentTab === 'online' ? 'prodigy-hoverBg border-[#0bd9b0]' : 'border-transparent'}`}
        onclick={() => currentTab = 'online'}>Online Player List</p>
        <p class={`text-red-500 prodigy-mainBg py-1.5 text-center w-full cursor-pointer border rounded-sm
        hover:border-red-600 hover:prodigy-negative-hoverBg duration-100
        ${currentTab === 'disconnected' ? 'prodigy-negative-hoverBg border-red-600' : 'border-transparent'}`}
        onclick={() => currentTab = 'disconnected'}>Disconnected Player List</p>
      </div>
      <div class="h-[500px] mt-4 flex flex-col gap-2 overflow-auto">
        {#if currentTab === 'online'}
          {#each players.online as ply}
            <Player ply={ply} />
          {/each}
        {:else}
          {#each players.offline as ply}
            <Player ply={ply} />
          {/each}
        {/if}
      </div>
  </div>
{/if}