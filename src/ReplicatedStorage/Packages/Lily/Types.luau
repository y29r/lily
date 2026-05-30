--!strict
--!native

export type Props = {[PropKey]: any}

export type ComponentFunction = (props: Props) -> Element

export type Kind = ComponentFunction | string

export type Element = {
	kind: string | ComponentFunction,
	props: Props,
}

export type Root = {
	render: (self: Root, element: Element) -> (),
	unmount: (self: Root) -> (),
}

export type Node = {
	cleanup: () -> (),
	update: (newElement: Element) -> Node,
}

export type PropKey = string | number | {}

export type SetState<Generic> = (newValue: Generic | (currentValue: Generic) -> Generic) -> Generic

export type HookContext = {
	slots: {any},
	index: number,
	rerender: () -> (),
}

return false