export interface PlayerData {
  username: string;
  id?: number;
  steam: string;
}

export interface JobData {
  label: string;
  count: number;
}

export interface Main { 
  maxPlayers?: number, 
  online?: PlayerData[], 
  offline?: PlayerData[], 
  jobs?: JobData[] 
}