<script lang="ts">
import Header from "$lib/components/Header.svelte";
import Player from "$lib/components/Player.svelte";
import { useNuiEvent } from "$lib/hooks/useNuiEvent";
import { type PlayerData } from "$lib/typings";
import { debugData } from "$lib/utils/debugData";
import { isEnvBrowser } from "$lib/utils/misc";

let visible: boolean = $state(false);
let players: PlayerData[] = $state([]);
let query = $state('');
let filter: PlayerData[] | undefined = $state();

let currentTab = $state('online')

$effect(() => {
  if (!query) {
    filter = players;
  };

  filter = players.filter(p => 
    p.username.toLowerCase().includes(query.toLowerCase()) ||
    p.id.toString().includes(query.toLowerCase())
  )
})

debugData<PlayerData[]>([
  {
    action: 'showList',
    data: [
      { username: 'Koil', id: 487 },
      { username: 'Ravage', id: 354 },
      { username: 'buddha', id: 105 }
    ]
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

useNuiEvent('showList', (data: PlayerData[]) => {
  visible = true;
  players = data;
})

function handleClose() {
  const wrapper = document.querySelector('.wrapper') as HTMLElement;
  wrapper!.style.animation = 'slideOut 250ms forwards';
  setTimeout(() => visible = false, 250);
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
  <div class="w-[550px] h-[650px] prodigy-bg rounded-3xl top-1/2 left-[84%] absolute -translate-x-1/2 -translate-y-1/2 p-7 wrapper">
      <Header totalPlayers={players.length} />
      <div class="my-2 flex items-center gap-3 text-[15px]">
        <p class={`text-[#0bd9b0] prodigy-mainBg py-1.5 text-center w-full cursor-pointer border rounded-sm
        hover:border-[#0bd9b0] hover:prodigy-hoverBg duration-100
        ${currentTab === 'online' ? 'prodigy-hoverBg border-[#0bd9b0]' : 'border-transparent'}`}
        onclick={() => currentTab = 'online'}>Online Player List</p>
        <p class={`text-red-500 prodigy-mainBg py-1.5 text-center w-full cursor-pointer border rounded-sm
        hover:border-red-600 hover:prodigy-negative-hoverBg duration-100
        ${currentTab === 'disconnected' ? 'prodigy-negative-hoverBg border-red-600' : 'border-transparent'}`}
        onclick={() => currentTab = 'disconnected'}>Disconnected Player List</p>
      </div>
  </div>
{/if}