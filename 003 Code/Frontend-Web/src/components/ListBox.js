import { styled } from "styled-components";
import ListHeader from "./ListHeader";
import ListBody from "./ListBody";
import ListPaginationBox from "./ListPaginationBox";

function ListBox() {
  const testBtnClick = async () => {
    await fetch("/list", {
      method: "GET",
      mode: "no-cors",
      headers: {
        "Content-Type": "application/json",
      },
    }).then((result) => {
      // console.log(result);
      result.json().then((re) => {
        console.log(re);
      });
      // let data = result.json();
      // data.then((re) => {
      //   console.log(re);
      // });
    });
    // .catch((err) => {
    //   console.log(err);
    // });
  };

  const dummy = [
    {
      name: "홍길동",
      grade: 1,
      email: "test1@test.com",
      amount: 2,
      time: "2023.07.26",
    },
    {
      name: "아무개",
      grade: 3,
      email: "test2@test.com",
      amount: 12,
      time: "2023.02.26",
    },
    {
      name: "김철수",
      grade: 2,
      email: "test3@test.com",
      amount: 6,
      time: "2023.05.11",
    },
    {
      name: "박진수",
      grade: 5,
      email: "test4@test.com",
      amount: 20,
      time: "2023.01.20",
    },
    {
      name: "신형만",
      grade: 1,
      email: "test5@test.com",
      amount: 0,
      time: "2023.02.10",
    },
    {
      name: "홍길동",
      grade: 1,
      email: "test1@test.com",
      amount: 2,
      time: "2023.07.26",
    },
    {
      name: "아무개",
      grade: 3,
      email: "test2@test.com",
      amount: 12,
      time: "2023.02.26",
    },
    {
      name: "김철수",
      grade: 2,
      email: "test3@test.com",
      amount: 6,
      time: "2023.05.11",
    },
    {
      name: "박진수",
      grade: 5,
      email: "test4@test.com",
      amount: 20,
      time: "2023.01.20",
    },
    {
      name: "신형만",
      grade: 1,
      email: "test5@test.com",
      amount: 0,
      time: "2023.02.10",
    },
  ];

  return (
    <ListBoxContainer>
      <button onClick={testBtnClick}>test</button>
      <ListContainer>
        <ListHeader />
        {dummy.map((e) => {
          return <ListBody name={e.name} grade={e.grade} email={e.email} amount={e.amount} time={e.time} />;
        })}
      </ListContainer>
      <ListPaginationBox></ListPaginationBox>
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
