import { styled } from "styled-components";
import { useEffect } from "react";
import markersrc from "../Image/warning.png";

function MapBox({ num1, num2 }) {
  useEffect(() => {
    const mapScript = document.createElement("script");
    mapScript.async = true;
    mapScript.src = "//dapi.kakao.com/v2/maps/sdk.js?appkey=f7d4ebdd98b5b81712647b8f4f71e07b&autoload=false";
    document.head.appendChild(mapScript);

    const onLoadKakaoMap = () => {
      window.kakao.maps.load(() => {
        const container = document.getElementById("kakaoMap");
        const options = {
          center: new window.kakao.maps.LatLng(num1, num2),
        };
        const map = new window.kakao.maps.Map(container, options);

        const imgSrc = markersrc;
        const imgSize = new window.kakao.maps.Size(32, 32);
        const imgOption = { offset: new window.kakao.maps.Point(10, 10) };
        const markerImg = new window.kakao.maps.MarkerImage(imgSrc, imgSize, imgOption);
        const markerPosition = new window.kakao.maps.LatLng(num1, num2);
        const marker = new window.kakao.maps.Marker({
          position: markerPosition,
          image: markerImg,
        });
        marker.setMap(map);

        const date = new Date();

        const year = date.getFullYear();
        const month = ("0" + (date.getMonth() + 1)).slice(-2);
        const day = ("0" + date.getDate()).slice(-2);
        const dateStr = year + "." + month + "." + day;

        const hours = ("0" + date.getHours()).slice(-2);
        const minutes = ("0" + date.getMinutes()).slice(-2);
        const seconds = ("0" + date.getSeconds()).slice(-2);
        const timeStr = hours + ":" + minutes + ":" + seconds;

        const iwContent = `<div style="width:10rem; height:5rem; display:flex; flex-direction: column"><p style="font-size:1.5rem;">차간 주행</p><p style="font-size:1rem;">${
          dateStr + " " + timeStr
        }</p></div>`;
        const iwPosition = new window.kakao.maps.LatLng(num1, num2);

        const infoWindow = new window.kakao.maps.InfoWindow({
          position: iwPosition,
          content: iwContent,
          removable: true,
        });

        window.kakao.maps.event.addListener(marker, "click", function () {
          infoWindow.open(map, marker);
        });
      });
    };
    mapScript.addEventListener("load", onLoadKakaoMap);

    return () => mapScript.removeEventListener("load", onLoadKakaoMap);
  }, [num1, num2]);
  return <MapContainer id="kakaoMap"></MapContainer>;
}

export default MapBox;

const MapContainer = styled.div`
  width: 100%;
  height: 100%;
`;
