import { styled } from "styled-components";

function ListPaginationBox() {
  return (
    <ListPaginationBoxContainer>
      <PaginationBtn>1</PaginationBtn>
      <PaginationBtn>2</PaginationBtn>
      <PaginationBtn>3</PaginationBtn>
      <PaginationBtn>4</PaginationBtn>
      <PaginationBtn>5</PaginationBtn>
    </ListPaginationBoxContainer>
  );
}

export default ListPaginationBox;

const ListPaginationBoxContainer = styled.div`
  width: 50rem;
  height: 5rem;
  margin-top: 3rem;
  display: flex;
  flex-direction: row;
  justify-content: space-around;
`;

const PaginationBtn = styled.button`
  width: 5rem;
  height: 100%;
  border: none;
  border-radius: 50%;
  background-color: white;
  &:focus {
    background-size: 2rem;
    background-color: #e8e6e6;
  }
`;
