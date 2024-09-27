use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
use protocol::models::{position::Position};

#[dojo::interface]
pub trait IAppActions<TContractState> {
    fn spawn(ref world: IWorldDispatcher);
    fn rewrite_position(ref world: IWorldDispatcher, position: Position);
}

#[dojo::contract(namespace: "protocol", nomapping: true)]
pub mod app_actions {
    use super::IActions;
    use starknet::{ContractAddress, get_caller_address};
    use protocol::models::{
        position::{Position, PositionStore, Vec2}, moves::{Moves, MovesStore, MovesEntityStore},
        direction::Direction,
    };


    #[abi(embed_v0)]
    impl ActionsImpl of IAppActions<ContractState> {
        fn spawn(ref world: IWorldDispatcher) {
            println!("spawn");
        }

        fn rewrite_position(ref world: IWorldDispatcher, position: Position) {
            println!("rewrite_position");
        }
    }
}
