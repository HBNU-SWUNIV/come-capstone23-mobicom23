import { styled } from "styled-components";
import LoginBox from "../components/LoginBox";

function LoginPage() {
  return (
    <LoginPageContainer>
      <LoginBox />
    </LoginPageContainer>
  );
}

export default LoginPage;

const LoginPageContainer = styled.div`
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
`;
