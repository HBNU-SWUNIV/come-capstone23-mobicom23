import { styled } from "styled-components";
import { useEffect, useState } from "react";
import markersrc from "../Image/warning.png";

function MapBox({ data, num1, num2 }) {
  const setMap = () => {
    const mapScript = document.createElement("script");
    mapScript.async = true;
    mapScript.src = `//dapi.kakao.com/v2/maps/sdk.js?appkey=f7d4ebdd98b5b81712647b8f4f71e07b&autoload=false`;
    document.head.appendChild(mapScript);

    const onLoadKakaoMap = () => {
      window.kakao.maps.load(() => {
        const container = document.getElementById("kakaoMap");
        const options = {
          center: new window.kakao.maps.LatLng(num1, num2),
        };
        const map = new window.kakao.maps.Map(container, options);

        data.map((el) => {
          const imgSrc = markersrc;
          const imgSize = new window.kakao.maps.Size(32, 32);
          const imgOption = { offset: new window.kakao.maps.Point(10, 10) };
          const markerImg = new window.kakao.maps.MarkerImage(imgSrc, imgSize, imgOption);
          const markerPosition = new window.kakao.maps.LatLng(el.latitude, el.longitude);
          const marker = new window.kakao.maps.Marker({
            position: markerPosition,
            image: markerImg,
          });
          marker.setMap(map);

          const iwContent = `<div style="width:10rem; height:5rem; display:flex; flex-direction: column"><p style="font-size:1.5rem;">${el.type}</p><p style="font-size:1rem;">${el.time}</p></div>`;
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
      });
    };
    mapScript.addEventListener("load", onLoadKakaoMap);

    return () => mapScript.removeEventListener("load", onLoadKakaoMap);
  };

  useEffect(() => {
    setMap();
    // const mapScript = document.createElement("script");
    // mapScript.async = true;
    // mapScript.src = `//dapi.kakao.com/v2/maps/sdk.js?appkey=f7d4ebdd98b5b81712647b8f4f71e07b&autoload=false`;
    // document.head.appendChild(mapScript);

    // const onLoadKakaoMap = () => {
    //   window.kakao.maps.load(() => {
    //     const container = document.getElementById("kakaoMap");
    //     const options = {
    //       center: new window.kakao.maps.LatLng(num1, num2),
    //     };
    //     const map = new window.kakao.maps.Map(container, options);

    //     data.forEach((el) => {
    //       const imgSrc = markersrc;
    //       const imgSize = new window.kakao.maps.Size(32, 32);
    //       const imgOption = { offset: new window.kakao.maps.Point(10, 10) };
    //       const markerImg = new window.kakao.maps.MarkerImage(imgSrc, imgSize, imgOption);
    //       const markerPosition = new window.kakao.maps.LatLng(el.latitude, el.longitude);
    //       const marker = new window.kakao.maps.Marker({
    //         position: markerPosition,
    //         image: markerImg,
    //       });
    //       marker.setMap(map);

    //       const iwContent = `<div style="width:10rem; height:5rem; display:flex; flex-direction: column"><p style="font-size:1.5rem;">${el.type}</p><p style="font-size:1rem;">${el.time}</p></div>`;
    //       const iwPosition = new window.kakao.maps.LatLng(num1, num2);

    //       const infoWindow = new window.kakao.maps.InfoWindow({
    //         position: iwPosition,
    //         content: iwContent,
    //         removable: true,
    //       });

    //       window.kakao.maps.event.addListener(marker, "click", function () {
    //         infoWindow.open(map, marker);
    //       });
    //     });
    //   });
    // };
    // mapScript.addEventListener("load", onLoadKakaoMap);

    // return () => mapScript.removeEventListener("load", onLoadKakaoMap);
  }, []);
  return <MapContainer id="kakaoMap"></MapContainer>;
}

export default MapBox;

const MapContainer = styled.div`
  width: 100%;
  height: 100%;
`;
