import { styled } from "styled-components";
import { useState, useEffect } from "react";
import { useRecoilValue } from "recoil";
import { getBodyState } from "../store/bodyState";
import MapBox from "./MapBox";
import ListBox from "./ListBox";

function MainBody() {
  const state = useRecoilValue(getBodyState);

  const [data, setData] = useState([]);
  const getDriveData = async () => {
    await fetch("/data/list", {
      method: "GET",
      mode: "no-cors",
      headers: {
        "Content-Type": "application/json",
      },
    }).then((result) => {
      result.json().then((response) => {
        // console.log(response);
        setData(response);
      });
    });
  };

  useEffect(() => {
    getDriveData();
  }, []);

  return (
    <MainBodyContainer>{state ? <MapBox num1={36.35183725966683} num2={127.3014373219504} data={data} /> : <ListBox />}</MainBodyContainer>
  );
}

export default MainBody;

const MainBodyContainer = styled.div`
  flex: 1;
`;
