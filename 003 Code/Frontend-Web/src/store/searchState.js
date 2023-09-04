import { atom, selector } from "recoil";

const searchState = atom({
  key: "searchState",
  default: "",
});

const getSearchState = selector({
  key: "getBodyState",
  get: ({ get }) => {
    const state = get(searchState);
    return state;
  },
});

export { searchState, getSearchState };
