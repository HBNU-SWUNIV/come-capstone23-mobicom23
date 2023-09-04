import { styled } from "styled-components";
import { useRecoilState } from "recoil";
import { bodyState } from "../store/bodyState";

function MainHeader({}) {
  const [body, setBody] = useRecoilState(bodyState);
  const MapBtnClick = () => {
    setBody(true);
  };
  const ListBtnClick = () => {
    setBody(false);
  };

  return (
    <MainHeaderContainer>
      <HeaderText>MOBICOM</HeaderText>
      <MapBtn onClick={MapBtnClick}>
        <BtnText>지도</BtnText>
      </MapBtn>
      <ListBtn onClick={ListBtnClick}>
        <BtnText>명단</BtnText>
      </ListBtn>
      <UserTextContainer>
        <UserText>홍길동님 환영합니다.</UserText>
      </UserTextContainer>
    </MainHeaderContainer>
  );
}

export default MainHeader;

const MainHeaderContainer = styled.div`
  width: 100%;
  height: 8rem;
  border-bottom-style: solid;
  border-bottom-width: 0.1rem;
  border-color: rgb(0, 0, 0, 0.3);
  display: flex;
  align-items: center;
`;

const HeaderText = styled.h1`
  font-size: 5rem;
  font-weight: 700;
`;

const MapBtn = styled.div`
  height: 100%;
  width: 10rem;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-left: 10rem;
  border-right-style: solid;
  border-right-width: 0.1rem;
  border-left-style: solid;
  border-left-width: 0.1rem;
  border-color: rgb(0, 0, 0, 0.3);
`;

const BtnText = styled.h2`
  font-size: 3rem;
  font-weight: 500;
`;

const ListBtn = styled.div`
  height: 100%;
  width: 10rem;
  display: flex;
  align-items: center;
  justify-content: center;
  border-right-style: solid;
  border-right-width: 0.1rem;
  border-color: rgb(0, 0, 0, 0.3);
`;

const UserTextContainer = styled.div`
  display: flex;
  flex: 1;
  height: 100%;
  align-items: center;
  justify-content: end;
`;

const UserText = styled.h5`
  font-size: 2rem;
  font-weight: 300;
`;
