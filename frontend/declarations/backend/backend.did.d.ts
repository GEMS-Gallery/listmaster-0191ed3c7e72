import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface PredefinedProduct {
  'name' : string,
  'emoji' : string,
  'category' : string,
}
export interface ShoppingItem {
  'id' : bigint,
  'completed' : boolean,
  'description' : string,
  'emoji' : string,
}
export interface _SERVICE {
  'addItem' : ActorMethod<[string, string], bigint>,
  'deleteItem' : ActorMethod<[bigint], boolean>,
  'getItems' : ActorMethod<[], Array<ShoppingItem>>,
  'getPredefinedProducts' : ActorMethod<[], Array<PredefinedProduct>>,
  'toggleItem' : ActorMethod<[bigint], boolean>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
