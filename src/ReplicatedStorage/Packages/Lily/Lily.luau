--!strict
--!native

const Button = require("./Button")
const ScreenGui = require("./ScreenGui")

const Types: boolean = require("./Types")
const Reconciler = require("./Reconciler/Reconciler")

const Tokens = require("./Tokens")
const Events = Tokens.Events

const useState = require("./useState")
const useEffect = require("./useEffect")

const createElement = require("./createElement")

export type Element = Types.Element
export type Root = Types.Root
export type SetState<Generic> = Types.SetState<Generic>
export type Props = Types.Props
export type ComponentFunction = Types.ComponentFunction

const Lily = {
	Button = Button,
	ScreenGui = ScreenGui,
	
	createElement = createElement,

	useState = useState,
	useEffect = useEffect,

	Events = Events,
	createRoot = Reconciler.createRoot,
}

return Lily