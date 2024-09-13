export const idlFactory = ({ IDL }) => {
  const ShoppingItem = IDL.Record({
    'id' : IDL.Nat,
    'completed' : IDL.Bool,
    'description' : IDL.Text,
    'emoji' : IDL.Text,
  });
  const PredefinedProduct = IDL.Record({
    'name' : IDL.Text,
    'emoji' : IDL.Text,
    'category' : IDL.Text,
  });
  return IDL.Service({
    'addItem' : IDL.Func([IDL.Text, IDL.Text], [IDL.Nat], []),
    'deleteItem' : IDL.Func([IDL.Nat], [IDL.Bool], []),
    'getItems' : IDL.Func([], [IDL.Vec(ShoppingItem)], ['query']),
    'getPredefinedProducts' : IDL.Func(
        [],
        [IDL.Vec(PredefinedProduct)],
        ['query'],
      ),
    'toggleItem' : IDL.Func([IDL.Nat], [IDL.Opt(ShoppingItem)], []),
  });
};
export const init = ({ IDL }) => { return []; };
