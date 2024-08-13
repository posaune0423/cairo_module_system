use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
use models::{direction::Direction, position::Position};

#[dojo::interface]
pub trait IActions<TContractState> {
    fn spawn(ref world: IWorldDispatcher);
}

#[dojo::contract(namespace: "protocol", nomapping: true)]
pub mod actions {
    use super::IActions;
    use starknet::{ContractAddress, get_caller_address};

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn spawn(ref world: IWorldDispatcher) {
            let player = get_caller_address();
            self.set_default_position(player, world);

            println!("Spawn!");
        }
    }


    #[generate_trait]
    impl InternalImpl of InternalUtils {
        fn set_default_position(
            self: @ContractState, player: ContractAddress, world: IWorldDispatcher
        ) {
            set!(
                world,
                (
                    Moves { player, remaining: 99, last_direction: Direction::None },
                    Position { player, vec: Vec2 { x: 10, y: 10 } },
                )
            );
        }
    }
}
