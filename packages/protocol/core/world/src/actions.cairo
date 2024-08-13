use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

#[dojo::interface]
pub trait IActions<TContractState> {
    fn spawn(ref world: IWorldDispatcher);
}

#[dojo::contract(namespace: "protocol", nomapping: true)]
pub mod actions {
    use super::IActions;
    use starknet::{ContractAddress, get_caller_address};
    use models::{position::{Position, Vec2}, moves::Moves, direction::Direction};


    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn spawn(ref world: IWorldDispatcher) {
            let player = get_caller_address();
            println!("Player: {:?}", player);

            set!(
                world,
                (
                    Moves { player, remaining: 99, last_direction: Direction::None },
                    Position { player, vec: Vec2 { x: 10, y: 10 } },
                )
            );

            println!("Spawn!");
        }
    }
}
