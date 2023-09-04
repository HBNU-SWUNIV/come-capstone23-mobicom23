import { styled } from "styled-components";

function ListHeader() {
  return (
    <ListHeaderContainer>
      <ListTitleContainer>
        <ListTitleText>이름</ListTitleText>
      </ListTitleContainer>
      <ListTitleContainer>
        <ListTitleText>등급</ListTitleText>
      </ListTitleContainer>
      <ListTitleContainer>
        <ListTitleText>Email</ListTitleText>
      </ListTitleContainer>
      <ListTitleContainer>
        <ListTitleText>횟수</ListTitleText>
      </ListTitleContainer>
      <ListTitleContainer>
        <ListTitleText>가입일자</ListTitleText>
      </ListTitleContainer>
    </ListHeaderContainer>
  );
}

export default ListHeader;

const ListHeaderContainer = styled.div`
  width: 100%;
  height: 10rem;
  border-bottom: 1px solid rgba(0, 0, 0, 0.2);
  display: flex;
  flex-direction: row;
`;

const ListTitleContainer = styled.div`
  width: 20%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
`;

const ListTitleText = styled.h3`
  font-size: 3rem;
  font-weight: 400;
`;
