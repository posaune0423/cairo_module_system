use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
use protocol::core::models::{direction::Direction};
use protocol::core::interfaces::actions::IActions;

#[dojo::contract(namespace: "protocol", nomapping: true)]
pub mod actions {
    use super::IActions;
    use starknet::{ContractAddress, get_caller_address};
    use models::{
        position::{Position, PositionStore, Vec2},
        moves::{Moves, MovesStore, MovesEntityStore},
        direction::Direction,
    };
    use utils::next_position;

    #[derive(Copy, Drop, Serde)]
    #[dojo::event]
    #[dojo::model]
    pub struct Moved {
        #[key]
        pub player: ContractAddress,
        pub direction: Direction,
    }


    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn spawn(ref world: IWorldDispatcher) {
            let player = get_caller_address();

            set!(
                world,
                (
                    Moves { player, remaining: 99, last_direction: Direction::None },
                    Position { player, vec: Vec2 { x: 10, y: 10 } },
                )
            );
        }

        fn move(ref world: IWorldDispatcher, direction: Direction) {
            let player = get_caller_address();

            // instead of using the `get!` macro, you can directly use
            // the <ModelName>Store::get method
            let mut position = PositionStore::get(world, player);

            // you can also get entity values by entity ID with the `<ModelName>EntityStore` trait.
            // Note that it returns a `<ModelName>Entity` struct which contains
            // model values and the entity ID.
            let move_id = MovesStore::entity_id_from_keys(player);
            let mut moves = MovesEntityStore::get(world, move_id);

            moves.remaining -= 1;
            moves.last_direction = direction;
            let next = next_position(position, direction);

            // instead of using the `set!` macro, you can directly use
            // the <ModelName>Store::set method
            next.set(world);

            // you can also update entity values by entity ID with the `<ModelName>EntityStore`
            // trait.
            moves.update(world);
            emit!(world, (Moved { player, direction }));
        }
    }
}
