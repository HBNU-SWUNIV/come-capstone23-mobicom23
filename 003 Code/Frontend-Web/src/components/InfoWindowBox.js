import { styled } from "styled-components";

function InfoWindowBox() {
  return (
    <InfoWindowBoxContainer>
      <TypeText>차간 주행</TypeText>
    </InfoWindowBoxContainer>
  );
}

export default InfoWindowBox;

const InfoWindowBoxContainer = styled.div`
  width: 10rem;
  height: 7rem;
  display: flex;
  flex-direction: column;
`;

const TypeText = styled.h3`
  font-size: 3rem;
`;
