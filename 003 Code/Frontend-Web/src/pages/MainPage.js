import { styled } from "styled-components";
import MainHeader from "../components/MainHeader";
import MainBody from "../components/MainBody";

function MainPage() {
  return (
    <MainnPageContainer>
      <MainHeader></MainHeader>
      <MainBody></MainBody>
    </MainnPageContainer>
  );
}

export default MainPage;

const MainnPageContainer = styled.div`
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
`;
