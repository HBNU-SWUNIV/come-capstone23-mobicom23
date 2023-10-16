import { styled } from "styled-components";

function ListPaginationBox({ total, limit, page, setPage }) {
  const numPages = Math.ceil(total / limit);

  return (
    <ListPaginationBoxContainer>
      <PaginationBtn onClick={() => setPage(page - 1)} disabled={page === 1}>
        &lt;
      </PaginationBtn>
      {Array(numPages)
        .fill()
        .map((_, i) => (
          <PaginationBtn key={i + 1} onClick={() => setPage(i + 1)} aria-current={page === i + 1 ? "page" : undefined}>
            {i + 1}
          </PaginationBtn>
        ))}
      <PaginationBtn onClick={() => setPage(page + 1)} disabled={page === numPages}>
        &gt;
      </PaginationBtn>
    </ListPaginationBoxContainer>
  );
}

export default ListPaginationBox;

const ListPaginationBoxContainer = styled.nav`
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 4px;
  margin: 16px;
`;

const PaginationBtn = styled.button`
  border: none;
  border-radius: 8px;
  padding: 8px;
  margin: 0;
  background: white;
  color: black;
  font-size: 1rem;

  &:hover {
    border: 1px solid;
    cursor: pointer;
    transform: translateY(-2px);
  }
  &[disabled] {
    background: white;
    border: 1px solid;
    color: black;
    cursor: revert;
    transform: revert;
  }
  &[aria-current] {
    background: #6cbae7;
    color: white;
    font-weight: bold;
    cursor: revert;
    transform: revert;
  }
`;
