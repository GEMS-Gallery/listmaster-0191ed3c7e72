import Bool "mo:base/Bool";
import List "mo:base/List";
import Text "mo:base/Text";

import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Option "mo:base/Option";

actor {
  public type ShoppingItem = {
    id: Nat;
    description: Text;
    completed: Bool;
    emoji: Text;
  };

  public type PredefinedProduct = {
    name: Text;
    emoji: Text;
    category: Text;
  };

  stable var shoppingList: [ShoppingItem] = [];
  stable var nextId: Nat = 0;

  let predefinedProducts: [PredefinedProduct] = [
    // Produce
    { name = "Apples"; emoji = "🍎"; category = "Produce" },
    { name = "Bananas"; emoji = "🍌"; category = "Produce" },
    { name = "Oranges"; emoji = "🍊"; category = "Produce" },
    { name = "Strawberries"; emoji = "🍓"; category = "Produce" },
    { name = "Grapes"; emoji = "🍇"; category = "Produce" },
    { name = "Lettuce"; emoji = "🥬"; category = "Produce" },
    { name = "Tomatoes"; emoji = "🍅"; category = "Produce" },
    { name = "Carrots"; emoji = "🥕"; category = "Produce" },
    { name = "Broccoli"; emoji = "🥦"; category = "Produce" },
    { name = "Potatoes"; emoji = "🥔"; category = "Produce" },
    { name = "Onions"; emoji = "🧅"; category = "Produce" },
    { name = "Garlic"; emoji = "🧄"; category = "Produce" },
    { name = "Avocados"; emoji = "🥑"; category = "Produce" },
    { name = "Lemons"; emoji = "🍋"; category = "Produce" },
    { name = "Limes"; emoji = "🍋"; category = "Produce" },
    // Bakery
    { name = "Bread"; emoji = "🍞"; category = "Bakery" },
    { name = "Bagels"; emoji = "🥯"; category = "Bakery" },
    { name = "Croissants"; emoji = "🥐"; category = "Bakery" },
    { name = "Muffins"; emoji = "🧁"; category = "Bakery" },
    { name = "Donuts"; emoji = "🍩"; category = "Bakery" },
    { name = "Cake"; emoji = "🍰"; category = "Bakery" },
    { name = "Cookies"; emoji = "🍪"; category = "Bakery" },
    { name = "Pie"; emoji = "🥧"; category = "Bakery" },
    { name = "Baguette"; emoji = "🥖"; category = "Bakery" },
    { name = "Rolls"; emoji = "🥐"; category = "Bakery" },
    // Dairy
    { name = "Milk"; emoji = "🥛"; category = "Dairy" },
    { name = "Cheese"; emoji = "🧀"; category = "Dairy" },
    { name = "Yogurt"; emoji = "🥛"; category = "Dairy" },
    { name = "Butter"; emoji = "🧈"; category = "Dairy" },
    { name = "Eggs"; emoji = "🥚"; category = "Dairy" },
    { name = "Cream"; emoji = "🥛"; category = "Dairy" },
    { name = "Sour Cream"; emoji = "🥛"; category = "Dairy" },
    { name = "Cottage Cheese"; emoji = "🧀"; category = "Dairy" },
    // Meat
    { name = "Chicken"; emoji = "🍗"; category = "Meat" },
    { name = "Beef"; emoji = "🥩"; category = "Meat" },
    { name = "Pork"; emoji = "🥓"; category = "Meat" },
    { name = "Fish"; emoji = "🐟"; category = "Meat" },
    { name = "Turkey"; emoji = "🦃"; category = "Meat" },
    { name = "Sausages"; emoji = "🌭"; category = "Meat" },
    { name = "Ham"; emoji = "🍖"; category = "Meat" },
    { name = "Bacon"; emoji = "🥓"; category = "Meat" },
    // Pantry
    { name = "Rice"; emoji = "🍚"; category = "Pantry" },
    { name = "Pasta"; emoji = "🍝"; category = "Pantry" },
    { name = "Cereal"; emoji = "🥣"; category = "Pantry" },
    { name = "Flour"; emoji = "🌾"; category = "Pantry" },
    { name = "Sugar"; emoji = "🍬"; category = "Pantry" },
    { name = "Salt"; emoji = "🧂"; category = "Pantry" },
    { name = "Pepper"; emoji = "🌶️"; category = "Pantry" },
    { name = "Olive Oil"; emoji = "🫒"; category = "Pantry" },
    { name = "Vinegar"; emoji = "🍶"; category = "Pantry" },
    { name = "Ketchup"; emoji = "🍅"; category = "Pantry" },
    { name = "Mustard"; emoji = "🌭"; category = "Pantry" },
    { name = "Mayonnaise"; emoji = "🥚"; category = "Pantry" },
    { name = "Peanut Butter"; emoji = "🥜"; category = "Pantry" },
    { name = "Jam"; emoji = "🍓"; category = "Pantry" },
    { name = "Honey"; emoji = "🍯"; category = "Pantry" },
    { name = "Soy Sauce"; emoji = "🍶"; category = "Pantry" },
    { name = "Tomato Sauce"; emoji = "🍅"; category = "Pantry" },
    { name = "Canned Beans"; emoji = "🥫"; category = "Pantry" },
    { name = "Canned Soup"; emoji = "🥫"; category = "Pantry" },
    { name = "Canned Tuna"; emoji = "🐟"; category = "Pantry" }
  ];

  public func addItem(description: Text, emoji: Text) : async Nat {
    let newItem: ShoppingItem = {
      id = nextId;
      description = description;
      completed = false;
      emoji = emoji;
    };
    shoppingList := Array.append(shoppingList, [newItem]);
    nextId += 1;
    nextId - 1
  };

  public query func getItems() : async [ShoppingItem] {
    shoppingList
  };

  public func toggleItem(id: Nat) : async Bool {
    let index = Array.indexOf<ShoppingItem>({ id = id; description = ""; completed = false; emoji = "" }, shoppingList, func(a, b) { a.id == b.id });
    switch (index) {
      case null { false };
      case (?i) {
        let item = shoppingList[i];
        let updatedItem = { id = item.id; description = item.description; completed = not item.completed; emoji = item.emoji };
        shoppingList := Array.tabulate(shoppingList.size(), func (j: Nat) : ShoppingItem {
          if (j == i) { updatedItem } else { shoppingList[j] }
        });
        true
      };
    }
  };

  public func deleteItem(id: Nat) : async Bool {
    let newList = Array.filter<ShoppingItem>(shoppingList, func(item) { item.id != id });
    if (newList.size() < shoppingList.size()) {
      shoppingList := newList;
      true
    } else {
      false
    }
  };

  public query func getPredefinedProducts() : async [PredefinedProduct] {
    predefinedProducts
  };
}