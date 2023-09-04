import { styled } from "styled-components";
import { useNavigate } from "react-router-dom";

function LoginBox() {
  const navigate = useNavigate();
  const LoginBtnClick = () => {
    fetch("/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        email: "sujin1234@naver.com",
        password: "123",
      }),
    }).then((result) => {
      // result.json().then((re) => {
      //   console.log(re);
      // });
      console.log(result);
      if (result.status === 200) {
        navigate("/main");
      }
    });
  };
  return (
    <LoginBoxcontainer>
      <TitleBox>
        <NameText>MOBICOM</NameText>
        <TitleText>관리자 로그인</TitleText>
      </TitleBox>
      <InputBox>
        <IdInput placeholder="아이디"></IdInput>
        <PwdInput placeholder="비밀번호"></PwdInput>
      </InputBox>
      <BtnBox>
        <LoginBtn
          onClick={() => {
            // navigate("/main");
            LoginBtnClick();
          }}
        >
          <BtnText>로그인</BtnText>
        </LoginBtn>
      </BtnBox>
      <BottomText>@Mobicom</BottomText>
    </LoginBoxcontainer>
  );
}

export default LoginBox;

const LoginBoxcontainer = styled.div`
  width: 40rem;
  height: 40rem;
  display: flex;
  border-radius: 12px;
  border: 1px solid rgba(0, 0, 0, 0.1);
  flex-direction: column;
  align-items: center;
  justify-content: center;
`;

const TitleBox = styled.div`
  width: 100%;
  height: 30%;
  display: flex;
  text-align: center;
  align-items: center;
  justify-content: center;
  flex-direction: column;
`;

const NameText = styled.h5`
  font-weight: 500;
  font-size: 3rem;
  margin-top: 1rem;
  margin-bottom: 1rem;
`;

const TitleText = styled.h2`
  font-weight: 700;
  font-size: 4rem;
`;

const InputBox = styled.div`
  display: flex;
  width: 100%;
  height: 45%;
  align-items: center;
  justify-content: center;
  flex-direction: column;
`;

const IdInput = styled.input`
  width: 80%;
  height: 25%;
  border-radius: 6px;
  border: 1px solid rgba(0, 0, 0, 0.3);
  margin-bottom: 20px;
`;

const PwdInput = styled.input`
  width: 80%;
  height: 25%;
  border-radius: 6px;
  border: 1px solid rgba(0, 0, 0, 0.3);
`;

const BottomText = styled.p`
  font-size: 1.5rem;
  opacity: 0.7;
  margin-bottom: 2rem;
`;

const BtnBox = styled.div`
  display: flex;
  width: 100%;
  height: 20%;
  justify-content: center;
`;

const LoginBtn = styled.div`
  width: 80%;
  height: 60%;
  border-radius: 6px;
  background-color: #6cbae7;
  display: flex;
  justify-content: center;
  align-items: center;
`;

const BtnText = styled.h2`
  color: white;
  font-weight: 500;
  font-size: 30px;
`;
