/**
 * ### Tutorial: Using `exports["mosquito-combatroll"]:combatroll`
 * I have unnecessarily made an export for this system so here's a usage tutorial.
 * The `combatroll` export allows you to force a roll animation on a player character with no checks. This can be used to create custom movement mechanics or evade actions in your game.
 *
 * #### Function Signature
 * `exports["mosquito-combatroll"]:combatroll(staminaDrain, direction, playerRelative)`
 *
 * #### Parameters
 * - **staminaDrain** (`number`): The amount of stamina to drain from the player when performing the roll. For reference, a value of `20` is approximately 1/8 of the player's full stamina bar/circle.
 * - **direction** (`string`): The direction in which the roll should occur. Valid values are:
 *   - `"fwd"` (forward)
 *   - `"back"` (backward)
 *   - `"left"` (left)
 *   - `"right"` (right)
 *   - `"fwd_left"` (forward-left)
 *   - `"fwd_right"` (forward-right)
 *   - `"back_left"` (backward-left)
 *   - `"back_right"` (backward-right)
 * - **playerRelative** (`boolean`): Determines the reference for the roll direction.
 *   - If `true`, the roll direction is relative to the player's current facing direction.
 *   - If `false`, the roll direction is relative to the camera's facing direction. For example, if the camera is facing the side of the player and you input `"fwd"` with `playerRelative = false`, the player will roll towards the camera's forward direction, using the appropriate side roll animation.
 *
 * #### Example Usage
 * ```lua
 * -- Roll forward relative to the player's facing direction, draining 20 stamina
 * exports["mosquito-combatroll"]:combatroll(20, "fwd", true)
 *
 * -- Roll right relative to the camera's facing direction, draining 10 stamina
 * exports["mosquito-combatroll"]:combatroll(10, "right", false)
 * ```
 *
 * #### Notes
 * - This function does not perform any checks before executing the roll animation.
 * - Use appropriate stamina values to balance gameplay.
 * - Choose the correct direction and relativity to achieve the desired roll behavior.
 */