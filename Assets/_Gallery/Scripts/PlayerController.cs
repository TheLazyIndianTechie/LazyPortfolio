using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerController : MonoBehaviour
{
    public float speed = 5f;
    public float mouseSensitivity = 150f;
    [HideInInspector] public Transform cameraTransform;

    CharacterController controller;
    InputAction moveAction;
    InputAction lookAction;

    Vector2 moveInput;
    Vector2 lookInput;
    float pitch = 0f;
    float velocityY = 0f;
    float gravity = -9.81f;

    void Awake()
    {
        controller = GetComponent<CharacterController>();

        // Automatically assign cameraTransform to first child (assumes only one camera as child)
        if (transform.childCount > 0)
        {
            cameraTransform = transform.GetChild(0);
        }
        else
        {
            Debug.LogError("PlayerController: No child found to assign as cameraTransform.");
        }

        // Create Move action (WASD & Arrow keys)
        moveAction = new InputAction(type: InputActionType.Value);
        moveAction.AddCompositeBinding("2DVector")
            .With("Up", "<Keyboard>/w")
            .With("Down", "<Keyboard>/s")
            .With("Left", "<Keyboard>/a")
            .With("Right", "<Keyboard>/d")
            .With("Up", "<Keyboard>/upArrow")
            .With("Down", "<Keyboard>/downArrow")
            .With("Left", "<Keyboard>/leftArrow")
            .With("Right", "<Keyboard>/rightArrow");

        // Create Look action (Mouse delta)
        lookAction = new InputAction(type: InputActionType.Value, binding: "<Mouse>/delta");
    }

    void OnEnable()
    {
        moveAction.Enable();
        lookAction.Enable();
    }

    void OnDisable()
    {
        moveAction.Disable();
        lookAction.Disable();
    }

    void Update()
    {
        moveInput = moveAction.ReadValue<Vector2>();
        lookInput = lookAction.ReadValue<Vector2>();

        // Mouse Look
        float mouseX = lookInput.x * mouseSensitivity * Time.deltaTime;
        float mouseY = lookInput.y * mouseSensitivity * Time.deltaTime;

        transform.Rotate(Vector3.up * mouseX);

        pitch -= mouseY;
        pitch = Mathf.Clamp(pitch, -90f, 90f);
        cameraTransform.localEulerAngles = new Vector3(pitch, 0, 0);

        // Movement
        Vector3 move = transform.right * moveInput.x + transform.forward * moveInput.y;
        move.Normalize();

        if (controller.isGrounded && velocityY < 0)
            velocityY = -2f;
        velocityY += gravity * Time.deltaTime;

        Vector3 velocity = move * speed + Vector3.up * velocityY;
        controller.Move(velocity * Time.deltaTime);
    }
}
