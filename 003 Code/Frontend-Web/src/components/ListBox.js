import { styled } from "styled-components";
import { useEffect, useState } from "react";
import ListHeader from "./ListHeader";
import ListBody from "./ListBody";
import ListPaginationBox from "./ListPaginationBox";

function ListBox() {
  const [limit, setLimit] = useState(10);
  const [page, setPage] = useState(1);
  const [data, setData] = useState([]);
  const offset = (page - 1) * limit;

  const getData = async () => {
    await fetch("/list", {
      method: "GET",
      mode: "no-cors",
      headers: {
        "Content-Type": "application/json",
      },
    }).then((result) => {
      result.json().then((response) => {
        console.log(response);
        setData(response);
      });
    });
  };

  useEffect(() => {
    getData();
  }, []);

  return (
    <ListBoxContainer>
      <ListContainer>
        <ListHeader />
        {data.slice(offset, offset + limit).map((e) => {
          return <ListBody id={e.id} email={e.email} amount={e.TotalDataCount} time={e.localDateTime} rank={e.rank} />;
        })}
      </ListContainer>
      <ListPaginationBox total={data.length} limit={limit} page={page} setPage={setPage}></ListPaginationBox>
    </ListBoxContainer>
  );
}

export default ListBox;

const ListBoxContainer = styled.div`
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
`;

const ListContainer = styled.div`
  width: 80%;
  height: 110rem;
  border-radius: 0.6rem;
  border: 1px solid rgba(0, 0, 0, 0.2);
`;

// const TestBtn = styled.div`
//   width: 100px;
//   height: 100px;
//   border: 1px solid rgba(0, 0, 0, 0.2);
// `;
