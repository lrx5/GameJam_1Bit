class_name MoveStateMachine
extends StateMachine


func _ready() -> void:
	for child in get_children():
		#Will only add to dictionary if the node is a Character State
		if child is MoveState:
			#inserts a key-value pair in the States Dictionary
			#child.name is the name of the node
			#child is the full id of the node
			states[child.name] = child
			child.changeState.connect(_onChangeState)
	
	#assigns the current state
	if initState != null and initState is MoveState:
		currentState = initState
		initState._enter()
		
func _process(delta: float) -> void:
	if currentState != null:
		currentState._processState(delta)

func _physics_process(delta: float) -> void:
	#checks if there is a current state
	if currentState != null:
		currentState._processPhysics(delta)

func _onChangeState(state: CharacterState, newStateName: CharacterState):
	#checks if the current state already changede
	if state == currentState:
		#Gets the key-value pair of newStateName from the States Dictionary
		#then assigns it as a new state
		var newState = states.get(newStateName.name)
		#checks if there is actually a newstate
		if newState != null:
			#checks if is currently in a state
			if currentState != null:
				currentState._exit()
			newState._enter()
			#makes the newly entered state as the new state
			currentState = newState
