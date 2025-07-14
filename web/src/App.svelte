<script lang="ts">
import Header from "$lib/components/Header.svelte";
import Player from "$lib/components/Player.svelte";
import { useNuiEvent } from "$lib/hooks/useNuiEvent";
import { type PlayerData } from "$lib/typings";
import { debugData } from "$lib/utils/debugData";
import { fetchNui } from "$lib/utils/fetchNui";
import { isEnvBrowser } from "$lib/utils/misc";

let visible: boolean = $state(false);
let players: { maxPlayers?: number, online?: PlayerData[], offline?: PlayerData[] } = $state({});
let query = $state('');

let currentTab = $state('online');
let filter = $state([]);

debugData<{ maxPlayers: number, online: PlayerData[], offline?: PlayerData[] }>([
  {
    action: 'showList',
    data: {
      maxPlayers: 48,
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

useNuiEvent('showList', (data: { maxPlayers: number, online: PlayerData[], offline?: PlayerData[] }) => {
  visible = true;
  players = data;
})

function handleClose() {
  const wrapper = document.querySelector('.wrapper') as HTMLElement;
  wrapper!.style.animation = 'slideOut 250ms forwards';
  setTimeout(() => visible = false, 250);

  fetchNui('hideList');
}

$effect(() => {
  const list = currentTab === 'online'
    ? players.online ?? []
    : players.offline ?? [];

  filter = list.filter(ply =>
    ply.username.toLowerCase().includes(query.toLowerCase()) ||
    (ply.id && ply.id.toString().includes(query.toLowerCase()))
  );
});

function onKeyDown(event: KeyboardEvent) {
  const target = event.target as HTMLElement;

  // Ignore if typing in an input, textarea, or contenteditable element
  if (
    target.tagName === 'INPUT' ||
    target.tagName === 'TEXTAREA' ||
    target.isContentEditable
  ) {
    return
  }

  const key = event.key.toLowerCase();

  switch (key) {
    case 'escape':
      return handleClose()
    case 'q':
      return currentTab = 'online'
    case 'e':
      return currentTab = 'offline'
  }
}
</script>

<svelte:window onkeydown={onKeyDown} />

{#if visible}
  <div class="absolute top-5 right-5 flex items-center gap-3 text-white">
    <div class="flex items-center gap-3 bg-black/65 px-5 py-2 rounded border border-neutral-600 transition-all duration-200 {currentTab === 'online' && 'border-lime-500 bg-lime-900/75'}">
      <p class="bg-black/50 px-1.5 rounded-sm text-[13px]">Q</p>
      <p>ONLINE PLAYERS</p>
    </div>
    <div class="flex items-center gap-3 bg-black/65 px-5 py-2 rounded border border-neutral-600 transition-all duration-200 {currentTab === 'offline' && 'border-lime-500 bg-lime-900/75'}">
      <p class="bg-black/50 px-1.5 rounded-sm text-[13px]">E</p>
      <p>OFFLINE PLAYERS</p>
    </div>
  </div>
  <div class="h-full w-[550px] top-1/2 left-[83%] absolute -translate-x-1/2 -translate-y-1/2 flex items-center">
    <div class="w-[550px] rounded-lg wrapper bg-black/65 border border-zinc-500 p-4 pr-0">
      <Header players={players} query={(text: string) => query = text} />
      <div class="flex flex-col gap-2 overflow-auto h-[400px] pr-4">
        {#each filter as ply}
          <Player player={ply} />
        {/each}
      </div>
    </div>
  </div>
{/if}