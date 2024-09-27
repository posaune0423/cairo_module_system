#[dojo::interface]
pub trait IActions<TContractState> {
    fn spawn(ref world: IWorldDispatcher);
    fn move(ref world: IWorldDispatcher, direction: Direction);
}
