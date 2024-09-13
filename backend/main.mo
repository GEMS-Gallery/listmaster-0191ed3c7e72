import Bool "mo:base/Bool";
import Func "mo:base/Func";
import List "mo:base/List";
import Text "mo:base/Text";

import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Option "mo:base/Option";

actor {
  // Define the structure for a shopping list item
  public type ShoppingItem = {
    id: Nat;
    description: Text;
    completed: Bool;
  };

  // Stable variable to store shopping list items
  stable var shoppingList: [ShoppingItem] = [];
  stable var nextId: Nat = 0;

  // Predefined products
  let predefinedProducts: [Text] = [
    "Milk", "Bread", "Eggs", "Cheese", "Apples",
    "Bananas", "Chicken", "Rice", "Pasta", "Tomatoes"
  ];

  // Function to add a new item to the shopping list
  public func addItem(description: Text) : async Nat {
    let newItem: ShoppingItem = {
      id = nextId;
      description = description;
      completed = false;
    };
    shoppingList := Array.append(shoppingList, [newItem]);
    nextId += 1;
    nextId - 1
  };

  // Function to get all items in the shopping list
  public query func getItems() : async [ShoppingItem] {
    shoppingList
  };

  // Function to toggle the completion status of an item
  public func toggleItem(id: Nat) : async Bool {
    let index = Array.indexOf<ShoppingItem>({ id = id; description = ""; completed = false }, shoppingList, func(a, b) { a.id == b.id });
    switch (index) {
      case null { false };
      case (?i) {
        let item = shoppingList[i];
        let updatedItem = { id = item.id; description = item.description; completed = not item.completed };
        shoppingList := Array.tabulate(shoppingList.size(), func (j: Nat) : ShoppingItem {
          if (j == i) { updatedItem } else { shoppingList[j] }
        });
        true
      };
    }
  };

  // Function to delete an item from the shopping list
  public func deleteItem(id: Nat) : async Bool {
    let newList = Array.filter<ShoppingItem>(shoppingList, func(item) { item.id != id });
    if (newList.size() < shoppingList.size()) {
      shoppingList := newList;
      true
    } else {
      false
    }
  };

  // New query function to get predefined products
  public query func getPredefinedProducts() : async [Text] {
    predefinedProducts
  };
}