import { styled } from "styled-components";

function ListBody({ id, email, amount, time, rank }) {
  return (
    <ListBodyContainer
      onClick={() => {
        console.log(`${email} is click`);
      }}
    >
      <ListContentContainer>
        <ListContentText>{id}</ListContentText>
      </ListContentContainer>
      <ListContentContainer>
        <ListContentText style={{ color: rank === "초록" ? "green" : rank === "노랑" ? "gold" : "red" }}>{rank}</ListContentText>
      </ListContentContainer>
      <ListContentContainer>
        <ListContentText>{email}</ListContentText>
      </ListContentContainer>
      <ListContentContainer>
        <ListContentText>{amount}</ListContentText>
      </ListContentContainer>
      <ListContentContainer>
        <ListContentText>{time}</ListContentText>
      </ListContentContainer>
    </ListBodyContainer>
  );
}

export default ListBody;

const ListBodyContainer = styled.div`
  width: 100%;
  height: 10rem;
  border-bottom: 1px solid rgba(0, 0, 0, 0.2);
  display: flex;
  flex-direction: row;

  &:hover {
    background-color: #dcdcdc;
  }
`;

const ListContentContainer = styled.div`
  width: 20%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
`;

const ListContentText = styled.h3`
  font-size: 3rem;
  font-weight: 400;
`;
