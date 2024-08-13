use starknet::{ContractAddress};
use models::direction::Direction;

#[derive(Copy, Drop, Serde)]
#[dojo::model(namespace: "protocol", nomapping: true)]
pub struct Moves {
    #[key]
    pub player: ContractAddress,
    pub remaining: u8,
    pub last_direction: Direction
}
